package team.marela.dragonhack.backend.database.repositories.organization;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.organization.OrganizationEntity;

import java.util.Optional;

public interface OrganizationRepository extends JpaRepository<OrganizationEntity, Integer> {
    Optional<OrganizationEntity> findByOrganizationName(String name);
}
