package team.marela.dragonhack.backend.database.entities.organization;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "organization")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrganizationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer organizationId;

    @Column(nullable = false, unique = true)
    private String organizationName;

    @OneToMany(mappedBy = "organization")
    private Set<WorkerEntity> employees;

    @OneToMany(mappedBy = "organization")
    private Set<EventEntity> events;
}
