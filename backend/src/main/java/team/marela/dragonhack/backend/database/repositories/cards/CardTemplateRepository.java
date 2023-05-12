package team.marela.dragonhack.backend.database.repositories.cards;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.cards.CardTemplateEntity;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;

import java.util.Optional;

public interface CardTemplateRepository extends JpaRepository<CardTemplateEntity, Integer> {
    Optional<CardTemplateEntity> findByEvent(EventEntity event);
}
