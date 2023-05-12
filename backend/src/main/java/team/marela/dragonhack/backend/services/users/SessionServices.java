package team.marela.dragonhack.backend.services.users;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.database.entities.organization.WorkerEntity;
import team.marela.dragonhack.backend.database.entities.users.SessionEntity;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;
import team.marela.dragonhack.backend.database.repositories.users.SessionRepository;
import team.marela.dragonhack.backend.exceptions.SessionException;
import team.marela.dragonhack.backend.functions.StringGenerator;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SessionServices {

    private final SessionRepository sessionRepository;

    private final static Integer SESSION_ID_LENGTH = 64;

    public SessionEntity getSession(String sessionId, UserEntity user) throws SessionException {
        return sessionRepository.findBySessionIdAndUser(
                sessionId, user
        ).orElseThrow(() -> new SessionException("Session ID is not valid"));
    }

    public String generateSessionId(UserEntity user) {
        var sessionId = validSessionId(
                sessionRepository.findAll().stream()
                        .map(SessionEntity::getSessionId)
                        .toList()
        );

        var session = sessionRepository.save(
                SessionEntity.builder()
                        .sessionId(sessionId)
                        .user(user)
                        .build()
        );

        return sessionId;
    }

    public String generateWorkerSessionId(WorkerEntity user) {
        var sessionId = validSessionId(
                sessionRepository.findAll().stream()
                        .map(SessionEntity::getSessionId)
                        .toList()
        );
//        var session = sessionRepository.save(
//                SessionEntity.builder()
//                        .sessionId(sessionId)
//                        .user(user)
//                        .build()
//        );
        return sessionId;
    }

    private String validSessionId(List<String> sessions) {
        var randomSession = StringGenerator.generateString(SESSION_ID_LENGTH);
        return sessions.stream()
                .anyMatch(e -> e.equals(randomSession))
        ? validSessionId(sessions)
        : randomSession;
    }
}
