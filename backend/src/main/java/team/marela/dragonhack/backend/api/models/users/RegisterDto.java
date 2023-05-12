package team.marela.dragonhack.backend.api.models.users;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RegisterDto {

    @NotBlank(message = "Firstname should not be blank")
    String firstname;

    @NotBlank(message = "Lastname should not be blank")
    String lastname;

    @NotBlank(message = "Email should not be blank")
    String email;

    @NotBlank(message = "Username should not be blank")
    String username;

    @NotBlank(message = "Password should not be blank")
    String password;
}
