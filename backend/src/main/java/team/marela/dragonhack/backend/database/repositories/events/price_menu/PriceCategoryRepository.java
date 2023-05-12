package team.marela.dragonhack.backend.database.repositories.events.price_menu;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.events.price_menu.PriceCategoryEntity;

public interface PriceCategoryRepository extends JpaRepository<PriceCategoryEntity, Integer> {
}
