package team.marela.dragonhack.backend.database.repositories.events.price_menu;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.events.price_menu.PriceItemEntity;

public interface PriceItemRepository extends JpaRepository<PriceItemEntity, Integer> {
}
