package team.marela.dragonhack.backend.api.app.users;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.web.bind.annotation.*;
import team.marela.dragonhack.backend.api.models.users.LoginDto;
import team.marela.dragonhack.backend.api.models.users.UserDto;
import team.marela.dragonhack.backend.exceptions.CredentialsInvalidException;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.services.users.LoginRegisterServices;
import team.marela.dragonhack.backend.services.users.SessionServices;

import javax.validation.Valid;

@Log
@RestController
@RequestMapping("/login")
@RequiredArgsConstructor
@CrossOrigin("*")
public class LoginApi {

    private final LoginRegisterServices loginRegisterServices;
    private final SessionServices sessionServices;

    @PostMapping
    public UserDto loginUser (@Valid @RequestBody LoginDto login) throws DataNotFoundException, CredentialsInvalidException {
        log.info("login");
        var user = loginRegisterServices.loginUser(login.getUsername(), login.getPassword());
        return new UserDto(
                user.getUsername(),
                user.getFirstname(),
                user.getLastname(),
                user.getEmail(),
                sessionServices.generateSessionId(user)
        );
    }
}
