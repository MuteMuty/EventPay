package team.marela.dragonhack.backend.database.entities.transactions;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity(name = "transaction_fillup")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FillUpEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer fillUpId;

    @Column(nullable = false)
    private BigDecimal amount;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @OneToOne
    @JoinColumn(name = "transaction_id")
    private TransactionEntity transaction;
}
