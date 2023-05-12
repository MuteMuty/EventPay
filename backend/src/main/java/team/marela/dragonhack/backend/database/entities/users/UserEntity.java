package team.marela.dragonhack.backend.database.entities.users;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.cards.CardEntity;
import team.marela.dragonhack.backend.database.entities.transactions.FillUpEntity;
import team.marela.dragonhack.backend.database.entities.transactions.OrderEntity;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "user")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String firstname;

    @Column(nullable = false)
    private String lastname;

    @Column(nullable = false)
    private String email;

    @OneToMany(mappedBy = "user")
    private Set<CardEntity> cards;

    @OneToMany(mappedBy = "user")
    private Set<OrderEntity> orders;

    @OneToMany(mappedBy = "user")
    private Set<FillUpEntity> fillUps;
}
