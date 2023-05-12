package team.marela.dragonhack.backend.database.entities.transactions;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.cards.CardEntity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity(name = "transaction")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TransactionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer transactionId;

    @Column(nullable = false)
    @Builder.Default
    private LocalDateTime created = LocalDateTime.now();

    @ManyToOne
    @JoinColumn(name = "card_id")
    private CardEntity card;

    @OneToOne(mappedBy = "transaction")
    private OrderEntity order;

    @OneToOne(mappedBy = "transaction")
    private FillUpEntity fillUp;
}
