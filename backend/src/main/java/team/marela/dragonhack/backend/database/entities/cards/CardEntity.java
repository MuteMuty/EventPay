package team.marela.dragonhack.backend.database.entities.cards;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;
import team.marela.dragonhack.backend.database.entities.transactions.TransactionEntity;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "card")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CardEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cardId;

    @Column(nullable = false, unique = true, length = 32)
    private String cardNumber;

    @ManyToOne
    @JoinColumn(name = "card_template_id")
    private CardTemplateEntity cardTemplate;

    @ManyToOne
    @JoinColumn(name = "event")
    private EventEntity event;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @OneToMany(mappedBy = "card")
    private Set<TransactionEntity> transactions;
}
