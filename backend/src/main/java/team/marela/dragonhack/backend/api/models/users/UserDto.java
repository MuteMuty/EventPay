package team.marela.dragonhack.backend.api.models.users;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
    String username;
    String firstname;
    String lastname;
    String email;
    String sessionId;
}
