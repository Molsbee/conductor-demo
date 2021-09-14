package io.lumen.edgevm.model.clc;

import io.lumen.edgevm.model.clc.Link;
import lombok.Data;

import java.util.List;
import java.util.Objects;

@Data
public class QueueResponse {
    private String server;
    private boolean isQueued;
    private List<Link> links;

    public String getServerUUID() {
        return this.links.stream()
                .filter(l -> Objects.equals(l.getRel(), "self"))
                .findFirst()
                .get()
                .getId();
    }
}
