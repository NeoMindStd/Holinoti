package com.neomind.holinoti_server.facility;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;
import org.springframework.context.annotation.Bean;
import com.bedatadriven.jackson.datatype.jts.JtsModule;
import org.springframework.data.geo.Point;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "facility")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@NamedStoredProcedureQuery(name = "Facility.findAllByCoordinates",
                procedureName = "DISTANCE", parameters = {
                @StoredProcedureParameter(mode = ParameterMode.IN, name = "lon", type = Double.class),
                @StoredProcedureParameter(mode = ParameterMode.IN, name = "lat", type = Double.class),
                @StoredProcedureParameter(mode = ParameterMode.IN, name = "side", type = Integer.class)},
                resultClasses = Facility.class
)

public class Facility implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "code", nullable = false)
    private int code;
    @Column(name = "name", nullable = false, unique = true)
    private String name;
    @Column(name = "address")
    private String address;
    @Column(name = "phone_number")
    private String phoneNumber;
    @Column(name = "site_url")
    private String siteUrl;
    @Column(name = "comment")
    private String comment;

    @Column(name = "coordinates")
    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(contentUsing = GeometryDeserializer.class)
    private Point coordinates;

    @Bean
    public JtsModule jtsModule()
    {
        return new JtsModule();
    }
}

