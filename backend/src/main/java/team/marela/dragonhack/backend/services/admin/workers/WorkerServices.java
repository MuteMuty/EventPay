package team.marela.dragonhack.backend.services.admin.workers;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.database.entities.organization.WorkerEntity;
import team.marela.dragonhack.backend.database.repositories.organization.WorkerRepository;
import team.marela.dragonhack.backend.exceptions.CredentialsInvalidException;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;

@Service
@RequiredArgsConstructor
public class WorkerServices {

    private final WorkerRepository workerRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public WorkerEntity loginUser(String username, String password) throws DataNotFoundException, CredentialsInvalidException {
        var user = workerRepository.findByUsername(username)
                .orElseThrow(() -> new DataNotFoundException("User with given username does not exists"));

        if (bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return user;
        } else {
            throw new CredentialsInvalidException("User credentials are invalid");
        }

    }
}
