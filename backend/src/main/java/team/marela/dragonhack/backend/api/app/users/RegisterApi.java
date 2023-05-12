package team.marela.dragonhack.backend.api.app.users;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.modelmapper.ModelMapper;
import org.springframework.web.bind.annotation.*;
import team.marela.dragonhack.backend.api.models.users.RegisterDto;
import team.marela.dragonhack.backend.api.models.users.UserDto;
import team.marela.dragonhack.backend.services.users.LoginRegisterServices;
import team.marela.dragonhack.backend.services.users.SessionServices;

import javax.validation.Valid;

@Log
@RestController
@RequestMapping("/register")
@RequiredArgsConstructor
@CrossOrigin("*")
public class RegisterApi {

    private final LoginRegisterServices loginRegisterServices;
    private final SessionServices sessionServices;
    private final ModelMapper modelMapper;

    @PostMapping
    public UserDto registerNewUser(@RequestBody @Valid RegisterDto user) {
        log.info("Register");
        var entity = loginRegisterServices.registerNewUser(user);
        var dto = modelMapper.map(entity, UserDto.class);
        dto.setSessionId(sessionServices.generateSessionId(entity));
        return dto;
    }
}
