# Design System Specialist for NimbusUI

This directory contains specialized configurations for working with NimbusUI as a design system using Claude Code.

## Overview

The Design System Specialist provides expert guidance for:
- Component library architecture and API design
- Design token system implementation and organization  
- Theming system enhancements and protocol design
- Cross-component consistency patterns
- Performance optimization of component libraries
- Accessibility integration in design systems

## Usage

### Basic Usage
Use the Task tool with design system specialized instructions:

```
Task tool with subagent_type: "general-purpose"
Include in prompt: "You are a Design System Specialist..."
```

### Example Usage Patterns

#### 1. Component Architecture Analysis
```
Prompt: "You are a Design System Specialist. Analyze the ButtonStyles architecture in NimbusUI and suggest improvements for better component composition and reusability."
```

#### 2. Design Token System Enhancement
```
Prompt: "You are a Design System Specialist. Review the current theming system and propose a hierarchical design token organization following industry best practices."
```

#### 3. New Component Development
```
Prompt: "You are a Design System Specialist. Help me design and implement a new Card component that follows NimbusUI's design patterns and integrates with the existing theming system."
```

#### 4. Performance Optimization
```
Prompt: "You are a Design System Specialist. Analyze the current component library for performance bottlenecks and suggest SwiftUI optimization strategies."
```

## Specialized Knowledge Areas

### Design System Architecture
- Protocol-based theming systems
- Environment-driven configuration patterns
- Component composition strategies
- Design token hierarchies (primitive → semantic → component)

### SwiftUI Expertise
- Custom view modifiers for consistent styling
- Environment value patterns and `@Entry` usage
- Performance optimization techniques
- State management in complex components

### Component Development
- API design for developer experience
- Accessibility integration patterns
- Animation and interaction design
- Testing strategies for component libraries

## Configuration Files

### `agents/design-system-specialist.md`
Defines the specialized agent capabilities and focus areas.

### `prompts/design-system-specialist-prompt.md`
Comprehensive prompt template with technical standards and best practices.

## Integration with CLAUDE.md

The main project CLAUDE.md file has been enhanced with Design System Specialist guidance that automatically applies when working on design system tasks.

## Benefits

1. **Expert Knowledge**: Specialized understanding of design system patterns and best practices
2. **Consistency**: Ensures architectural decisions align with design system principles
3. **Performance**: Optimized solutions for component library use cases
4. **Developer Experience**: Focus on API design and documentation quality
5. **Accessibility**: Built-in accessibility expertise for all components
6. **Scalability**: Architectural patterns that support library growth

## Technical Standards

All recommendations follow:
- Swift API Design Guidelines
- SwiftUI best practices and performance patterns
- macOS accessibility requirements
- Design system industry standards
- NimbusUI's existing architectural patterns

## Examples

See the test analysis provided for the NimbusUI theming system as an example of the specialized knowledge and structured approach this system provides.