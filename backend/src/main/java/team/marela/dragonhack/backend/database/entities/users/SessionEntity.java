package team.marela.dragonhack.backend.database.entities.users;

import lombok.*;

import javax.persistence.*;

@Entity(name = "session")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SessionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer internalId;

    @Column(nullable = false, unique = true)
    private String sessionId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;
}
