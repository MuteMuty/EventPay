package team.marela.dragonhack.backend.database.repositories.users;

import org.springframework.data.jpa.repository.JpaRepository;
import team.marela.dragonhack.backend.database.entities.users.SessionEntity;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;

import java.util.Optional;

public interface SessionRepository extends JpaRepository<SessionEntity, Integer> {
    Optional<SessionEntity> findBySessionId(String sessionId);

    Optional<SessionEntity> findBySessionIdAndUser(String sessionId, UserEntity user);
}
