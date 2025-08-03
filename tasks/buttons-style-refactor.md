### **Objective**

Refactor and expand the SwiftUI `ButtonStyle` system within the `NimbusUI` library to establish consistent naming conventions, visual styles, and size variations.

### **Core Requirements**

1.  **Standardize Naming:** Adopt a clear and consistent naming scheme for all button styles.
2.  **`controlSize` Support:** All button styles must adapt their appearance (padding, font size, etc.) based on the standard SwiftUI `controlSize` environment property (`.large`, `.regular`, `.small`, `.mini`). This will be the primary mechanism for controlling button size.
3.  **Feature Parity:** All styles must continue to support existing functionalities, including:
    *   Optional icons with leading or trailing placement.
    *   Optional separators.

---

### **Task Breakdown**

#### **1. Refactor Existing Button Styles**

*   **`PrimaryDefaultButtonStyle` -> `PrimaryButtonStyle`**
    *   **Action:** Rename the style.
    *   **Enhancement:** Implement support for all `controlSize` variants.

*   **`PrimaryProminentButtonStyle` -> `AccentButtonStyle`**
    *   **Action:** Rename the style.
    *   **Enhancement:** Implement support for all `controlSize` variants.

*   **`SecondaryProminentButtonStyle` -> (Deprecate)**
    *   **Action:** Remove this style.
    *   **Reasoning:** Its functionality will be fully covered by `AccentButtonStyle` using a larger `controlSize`.

*   **`SecondaryBorderedButtonStyle` -> `SecondaryOutlineButtonStyle`**
    *   **Action:** Rename the style.
    *   **Enhancement:** The existing implementation will become the `.regular` size variant. Implement `.large`, `.small`, and `.mini` size variants.

#### **2. Introduce New Button Styles**

*   **`PrimaryOutlineButtonStyle`**
    *   **Description:** A button style with a transparent background and a colored border.
    *   **Visuals:** The border color should be the same as the background color of the `PrimaryButtonStyle`.
    *   **Sizing:** Must support all `controlSize` variants.

*   **`SecondaryButtonStyle`**
    *   **Description:** A filled button style with a less prominent appearance than `PrimaryButtonStyle`.
    *   **Visuals:** The background color should be a subtle, less saturated, or lighter/darker variant of the `PrimaryButtonStyle` color, depending on the theme.
    *   **Sizing:** Must support all `controlSize` variants.

---
### **3. Update Documentation**

*   **Action:** After all button style refactoring is complete, update all relevant documentation.
*   **Files to Update:**
    *   `README.md`: Refresh any sections describing button styles, their usage, and naming conventions.
    *   `CLAUDE.md`: Update any internal development notes or guidelines related to the button components.