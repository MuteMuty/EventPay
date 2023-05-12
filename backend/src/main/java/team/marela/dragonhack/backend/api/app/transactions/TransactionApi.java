package team.marela.dragonhack.backend.api.app.transactions;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import team.marela.dragonhack.backend.api.models.cards.CardDto;
import team.marela.dragonhack.backend.api.models.transactions.TransactionPostModel;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.exceptions.NegativeBalanceException;
import team.marela.dragonhack.backend.services.cards.transactions.TransactionServices;

import javax.validation.Valid;

@RestController
@RequestMapping("/transactions")
@RequiredArgsConstructor
public class TransactionApi {

    private final TransactionServices transactionServices;

    @PostMapping("/fillup")
    public boolean fillCardUp(@RequestBody @Valid TransactionPostModel dto) throws DataNotFoundException {
        transactionServices.fillUpCard(dto.getCardNumber(), dto.getAmount());
        return true;
    }


    @PostMapping("/order")
    public boolean order(@RequestBody @Valid TransactionPostModel dto) throws DataNotFoundException, NegativeBalanceException {
        transactionServices.createOrderOnCard(dto.getCardNumber(), dto.getAmount(), dto.getWorkerUsername());
        return true;
    }
}
