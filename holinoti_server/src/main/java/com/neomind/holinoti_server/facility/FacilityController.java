package com.neomind.holinoti_server.facility;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = "/facilities", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class FacilityController {
    FacilityRepository facilityRepository;

    @GetMapping
    public List<Facility> getAllFacilities() {
        return facilityRepository.findAll();
    }

    @RequestMapping(path = "/{facilityCode}", method = RequestMethod.GET)
    public Facility getFacility(@PathVariable("facilityCode") int code) {
        return facilityRepository.findById(code).get();
    }

    @PostMapping
    public ResponseEntity addFacility(@RequestBody Facility facility) {
        System.out.println(facility);
        Facility newFacility = facilityRepository.save(facility);
        URI createdURI = linkTo(FacilityController.class).slash(newFacility.getCode()).toUri();
        return ResponseEntity.created(createdURI).body(newFacility);
    }

    @RequestMapping(path = "/{facilityCode}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateFacility(@RequestBody Facility facility,
                               @PathVariable("facilityCode") int code) {
        Facility target = facilityRepository.findById(code).get();

        target.setCode(facility.getCode());
        target.setName(facility.getName());
        target.setAddress(facility.getAddress());

        facilityRepository.save(target);
    }

    @RequestMapping(path = "/{facilityCode}", method = RequestMethod.DELETE)
    public void deleteFacility(@PathVariable("facilityCode") int code) {
        facilityRepository.deleteById(code);
    }
}