package team.marela.dragonhack.backend.api.app.cards;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import team.marela.dragonhack.backend.api.models.cards.CardDto;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.services.cards.CardServices;
import team.marela.dragonhack.backend.services.cards.CardTransactionServices;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/cards")
@RequiredArgsConstructor
public class CardsApi {

    private final CardServices cardServices;
    private final CardTransactionServices cardTransactionServices;

    @GetMapping
    public List<CardDto> getUsersCards(@RequestHeader("Username") String username) throws DataNotFoundException {
        return cardTransactionServices.getAllUsersCards(username);
    }

    @PostMapping("/create/{eventId}")
    public CardDto createNewCard(@RequestHeader("Username") String username, @PathVariable Integer eventId) throws DataNotFoundException {
        var entity = cardServices.generateNewCard(eventId, username);
        return CardDto.builder()
                .cardNumber(entity.getCardNumber())
                .image(entity.getCardTemplate().getImage())
                .amount(BigDecimal.ZERO)
                .build();
    }
}
