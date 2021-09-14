package io.lumen.edgevm.model;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class SubWorkflowParam {
    private String name;
    private int version;
    private Map<String, Object> taskToDomain;
    private WorkflowDef workflowDefinition;
}
