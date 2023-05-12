package team.marela.dragonhack.backend.database.entities.cards;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "card_template")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CardTemplateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cardTemplateId;

    @Lob
    private String image;

    @OneToOne
    @JoinColumn(name = "event_id")
    private EventEntity event;

    @OneToMany(mappedBy = "cardTemplate")
    private Set<CardEntity> cards;
}
