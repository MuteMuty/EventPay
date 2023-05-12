package team.marela.dragonhack.backend.api.admin.users;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.web.bind.annotation.*;
import team.marela.dragonhack.backend.api.models.users.LoginDto;
import team.marela.dragonhack.backend.api.models.users.UserDto;
import team.marela.dragonhack.backend.exceptions.CredentialsInvalidException;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.services.admin.workers.WorkerServices;
import team.marela.dragonhack.backend.services.users.SessionServices;

import javax.validation.Valid;

@Log
@RestController
@RequestMapping("/admin/login")
@RequiredArgsConstructor
@CrossOrigin("*")
public class AdminLoginApi {

    private final WorkerServices workerServices;
    private final SessionServices sessionServices;

    @PostMapping
    public UserDto loginUser (@Valid @RequestBody LoginDto login) throws DataNotFoundException, CredentialsInvalidException {
        log.info("login");
        var user = workerServices.loginUser(login.getUsername(), login.getPassword());
        return new UserDto(
                user.getUsername(),
                user.getFirstname(),
                user.getLastname(),
                user.getEmail(),
                sessionServices.generateWorkerSessionId(user)
        );
    }
}
