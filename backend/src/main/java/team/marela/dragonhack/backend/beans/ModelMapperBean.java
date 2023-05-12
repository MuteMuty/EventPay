package team.marela.dragonhack.backend.beans;

import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

@Service
public class ModelMapperBean {

    @Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }
}
