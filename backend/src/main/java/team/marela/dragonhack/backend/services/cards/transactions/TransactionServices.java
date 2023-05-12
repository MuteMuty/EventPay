package team.marela.dragonhack.backend.services.cards.transactions;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.api.models.cards.CardDto;
import team.marela.dragonhack.backend.api.models.cards.TransactionsDto;
import team.marela.dragonhack.backend.database.entities.cards.CardEntity;
import team.marela.dragonhack.backend.database.entities.events.EventDayEntity;
import team.marela.dragonhack.backend.database.entities.transactions.FillUpEntity;
import team.marela.dragonhack.backend.database.entities.transactions.OrderEntity;
import team.marela.dragonhack.backend.database.entities.transactions.TransactionEntity;
import team.marela.dragonhack.backend.database.repositories.organization.OrganizationRepository;
import team.marela.dragonhack.backend.database.repositories.organization.WorkerRepository;
import team.marela.dragonhack.backend.database.repositories.transactions.FillUpRepository;
import team.marela.dragonhack.backend.database.repositories.transactions.OrderRepository;
import team.marela.dragonhack.backend.database.repositories.transactions.TransactionRepository;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.exceptions.NegativeBalanceException;
import team.marela.dragonhack.backend.services.cards.CardServices;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.Objects;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class TransactionServices {

    private final CardServices cardServices;

    private final TransactionRepository transactionRepository;
    private final FillUpRepository fillUpRepository;
    private final OrderRepository orderRepository;

    private final WorkerRepository workerRepository;
    private final OrganizationRepository organizationRepository;

    public FillUpEntity fillUpCard(String cardNumber, BigDecimal amount) throws DataNotFoundException {
        var card = cardServices.getCard(cardNumber);
        var user = card.getUser();
        assert user != null;

        var transaction = transactionRepository.save(
                TransactionEntity.builder()
                        .card(card)
                        .build()
        );

        var fillUp = FillUpEntity.builder()
                .amount(amount)
                .user(user)
                .transaction(transaction)
                .build();

        return fillUpRepository.save(fillUp);
    }

    public OrderEntity createOrderOnCard(String cardNumber, BigDecimal amount, String workerUsername) throws DataNotFoundException, NegativeBalanceException {
        var card = cardServices.getCard(cardNumber);

        if (getCardBalance(card).subtract(amount).compareTo(BigDecimal.ZERO) <= 0) {
            throw new NegativeBalanceException("Balance is too low");
        }

        var user = card.getUser();
        var event = cardServices.findCardsEvent(card);

        var worker = workerRepository.findByUsernameAndOrganization(
                workerUsername,
                event.getOrganization()
        ).orElseThrow(() -> new DataNotFoundException("Worker not found"));

        var transaction = transactionRepository.save(
                TransactionEntity.builder()
                        .card(card)
                        .build()
        );

        var order = orderRepository.save(
                OrderEntity.builder()
                        .amount(amount)
                        .transaction(transaction)
                        .worker(worker)
                        .user(user)
                        .build()
        );

        return order;
    }

    public CardDto getCardInfo(String cardNumber) throws DataNotFoundException {
        var card = cardServices.getCard(cardNumber);
        var event = card.getEvent();

        var transactions = transactionRepository.findByCard(card);
        var orders = transactions.stream()
                .filter(e -> e.getOrder() != null)
                .map(e -> TransactionsDto.builder()
                        .amount(e.getOrder().getAmount().multiply(BigDecimal.valueOf(-1.0)))
                        .created(e.getCreated())
                        .build()
                )
                .toList();

        var fillUps = transactions.stream()
                .filter(e -> e.getFillUp() != null)
                .map(e -> TransactionsDto.builder()
                        .amount(e.getFillUp().getAmount())
                        .created(e.getCreated())
                        .build()
                ).toList();


        var transactionDtos = Stream.concat(
                        orders.stream(),
                        fillUps.stream()
                )
                .sorted(Comparator.comparing(TransactionsDto::getCreated))
                .toList();

        return CardDto.builder()
                .eventName(event.getEventName())
                .startTime(
                        event.getEventDays().stream()
                                .map(EventDayEntity::getEventStart)
                                .min(LocalDateTime::compareTo)
                                .get()
                )
                .endTime(
                        event.getEventDays().stream()
                                .map(EventDayEntity::getEventEnd)
                                .max(LocalDateTime::compareTo)
                                .get()
                )
                .image(card.getCardTemplate().getImage())
                .amount(
                        transactionDtos.stream()
                                .map(TransactionsDto::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add)
                )
                .transactions(transactionDtos)
                .cardNumber(cardNumber)
                .location(event.getLocation())
                .build();
    }

    private BigDecimal getCardBalance(CardEntity card) {
        var in = card.getTransactions().stream()
                .map(TransactionEntity::getFillUp)
                .filter(Objects::nonNull)
                .map(FillUpEntity::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        var out = card.getTransactions().stream()
                .map(TransactionEntity::getOrder)
                .filter(Objects::nonNull)
                .map(OrderEntity::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return in.subtract(out);
    }
}
