package team.marela.dragonhack.backend.api.models.cards;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransactionsDto {
    LocalDateTime created;
    BigDecimal amount;
}
