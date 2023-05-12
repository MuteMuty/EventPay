package team.marela.dragonhack.backend.database.repositories.organization;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.organization.OrganizationEntity;
import team.marela.dragonhack.backend.database.entities.organization.WorkerEntity;

import java.util.Optional;

public interface WorkerRepository extends JpaRepository<WorkerEntity, Integer> {
    Optional<WorkerEntity> findByUsernameAndOrganization(String username, OrganizationEntity organization);
    Optional<WorkerEntity> findByUsername(String username);
}
