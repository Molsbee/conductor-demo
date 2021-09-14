package io.lumen.edgevm.model;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class WorkflowTask {
    private String name;
    private String taskReferenceName;
    @Builder.Default
    private String type = "SIMPLE";
    private Map<String, Object> inputParameters;
}
