package team.marela.dragonhack.backend.database.repositories.transactions;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.transactions.OrderEntity;

public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {
}
