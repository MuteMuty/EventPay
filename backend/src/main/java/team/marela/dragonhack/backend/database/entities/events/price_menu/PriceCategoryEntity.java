package team.marela.dragonhack.backend.database.entities.events.price_menu;

import lombok.*;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "price_category")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PriceCategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer categoryId;

    @OneToMany(mappedBy = "category")
    private Set<PriceItemEntity> items;
}
