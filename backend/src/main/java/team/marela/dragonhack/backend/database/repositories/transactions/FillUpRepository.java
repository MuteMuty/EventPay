package team.marela.dragonhack.backend.database.repositories.transactions;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.transactions.FillUpEntity;

public interface FillUpRepository extends JpaRepository<FillUpEntity, Integer> {
}
