package team.marela.dragonhack.backend.services.cards;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.api.models.cards.CardDto;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.services.cards.transactions.TransactionServices;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CardTransactionServices {

    private final TransactionServices transactionServices;
    private final CardServices cardServices;

    public List<CardDto> getAllUsersCards(String username) throws DataNotFoundException {
        var cards = cardServices.getAllUsersCards(username);
        var cardDtos = new ArrayList<CardDto>();
        for(var card : cards) {
            cardDtos.add(
                    transactionServices.getCardInfo(card.getCardNumber())
            );
        }

        return cardDtos;
    }
}
