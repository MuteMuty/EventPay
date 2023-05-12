package team.marela.dragonhack.backend.database.repositories.events;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import team.marela.dragonhack.backend.database.entities.cards.CardTemplateEntity;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;
import team.marela.dragonhack.backend.database.entities.organization.OrganizationEntity;

import java.util.List;
import java.util.Optional;

public interface EventRepository extends JpaRepository<EventEntity, Integer> {

//    @Query("select e from EventEntity e where e.eventId = :id")
//    Optional<EventEntity> findByCardTemplate(CardTemplateEntity cardTemplate);

    List<EventEntity> findAllByOrganization(OrganizationEntity organization);
}
