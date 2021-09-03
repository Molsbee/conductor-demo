package io.lumen.edgevm.model;

import lombok.Data;

@Data
public class Link {
    private String rel;
    private String href;
    private String id;
    private String name;
}
