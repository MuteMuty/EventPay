package team.marela.dragonhack.backend.database.entities.events.price_menu;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;

import javax.persistence.*;

@Entity(name = "price_item")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PriceItemEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer priceItemId;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private PriceCategoryEntity category;

    @ManyToOne
    @JoinColumn(name = "event_id")
    private EventEntity event;
}
