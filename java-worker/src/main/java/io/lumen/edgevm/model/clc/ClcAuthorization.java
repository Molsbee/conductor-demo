package io.lumen.edgevm.model.clc;

import lombok.Data;
import java.util.List;

@Data
public class ClcAuthorization {
    private String userName;
    private String accountAlias;
    private String locationAlias;
    private List<String> roles;
    private String bearerToken;
}
