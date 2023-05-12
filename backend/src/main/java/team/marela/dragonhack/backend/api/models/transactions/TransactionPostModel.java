package team.marela.dragonhack.backend.api.models.transactions;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransactionPostModel {
    @NotBlank
    String cardNumber;
    String workerUsername;
    @NotNull
    BigDecimal amount;
}
