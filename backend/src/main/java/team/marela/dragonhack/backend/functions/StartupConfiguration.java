package team.marela.dragonhack.backend.functions;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.database.entities.organization.OrganizationEntity;
import team.marela.dragonhack.backend.database.entities.organization.WorkerEntity;
import team.marela.dragonhack.backend.database.entities.users.UserEntity;
import team.marela.dragonhack.backend.database.repositories.organization.OrganizationRepository;
import team.marela.dragonhack.backend.database.repositories.organization.WorkerRepository;
import team.marela.dragonhack.backend.database.repositories.users.UserRepository;

@Service
@RequiredArgsConstructor
public class StartupConfiguration {

    private final WorkerRepository workerRepository;
    private final OrganizationRepository organizationRepository;

    private final UserRepository userRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @EventListener(ApplicationReadyEvent.class)
    public void onStartup() {
        generateWorker();
        createUser();
    }

    private void generateWorker() {
        final String organizationName = "EventPay Firma";
        final String workerUsername = "janez";
        var organization =
                organizationRepository.findByOrganizationName(organizationName)
                        .orElseGet(() -> organizationRepository.save(
                                OrganizationEntity.builder()
                                        .organizationName(organizationName)
                                        .build()
                        ));

        var worker =
                workerRepository.findByUsername(workerUsername)
                        .orElseGet(() -> workerRepository.save(
                                WorkerEntity.builder()
                                        .email("janez.slovenec@mail.si")
                                        .firstname("Janez")
                                        .lastname("Slovenec")
                                        .password(bCryptPasswordEncoder.encode("mavrica"))
                                        .username(workerUsername)
                                        .isOrganizationAdmin(true)
                                        .organization(organization)
                                        .build()
                        ));
    }

    public void createUser() {
        final String username = "erik";
        userRepository.findByUsername(username).orElseGet(() ->
                userRepository.save(
                        UserEntity.builder()
                                .username(username)
                                .email("erik@user.si")
                                .password(bCryptPasswordEncoder.encode("erikerik"))
                                .firstname("Uporabnik")
                                .lastname("Erik")
                                .build()
                )
        );
    }
}
