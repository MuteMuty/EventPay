package team.marela.dragonhack.backend.services.users;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.api.models.users.RegisterDto;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;
import team.marela.dragonhack.backend.database.repositories.users.UserRepository;
import team.marela.dragonhack.backend.exceptions.CredentialsInvalidException;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;

@Service
@RequiredArgsConstructor
public class LoginRegisterServices {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserEntity registerNewUser(RegisterDto dto) {
        var userEntity = UserEntity.builder()
                .username(dto.getUsername())
                .password(bCryptPasswordEncoder.encode(dto.getPassword()))
                .firstname(dto.getFirstname())
                .lastname(dto.getLastname())
                .email(dto.getEmail())
                .build();

        return userRepository.save(userEntity);
    }

    public UserEntity loginUser(String username, String password) throws DataNotFoundException, CredentialsInvalidException {
        var user = userRepository.findByUsername(username)
                .orElseThrow(() -> new DataNotFoundException("User with given username does not exists"));

        if (bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return user;
        } else {
            throw new CredentialsInvalidException("User credentials are invalid");
        }

    }
}
