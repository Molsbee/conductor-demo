package io.lumen.edgevm.model;

import lombok.Data;
import java.util.List;
import java.util.Objects;

@Data
public class DataCenter {
    private String id;
    private String name;
    private List<Link> links;

    public String getHardwareGroupID() {
        return this.links.stream().filter(l -> (Objects.equals(l.getRel(), "group"))).findFirst().get().getId();
    }
}
