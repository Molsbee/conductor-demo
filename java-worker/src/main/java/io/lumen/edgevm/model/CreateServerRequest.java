package io.lumen.edgevm.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CreateServerRequest {
    private String name;
    private String groupId;
    private String sourceServerId;
    private String password;
    private int cpu;
    private int memoryGB;
    private String ttl;
}
