# Figma to Flutter Checklist

Use this checklist before starting development to ensure you have everything needed from the Figma design.

## Pre-Development Checklist

### Design Completeness

- [ ] All screens are designed and approved
- [ ] All user flows are documented
- [ ] Interactive prototype is available
- [ ] All breakpoints/responsive layouts defined
- [ ] Dark mode designs provided (if applicable)

### Design States

- [ ] Default/normal state
- [ ] Loading state
- [ ] Error state
- [ ] Empty state
- [ ] Success state
- [ ] Disabled state
- [ ] Hover state (web/desktop)
- [ ] Focus state (web/desktop)
- [ ] Active/pressed state

### Colors

- [ ] All colors extracted with hex values
- [ ] Semantic color names defined (primary, secondary, etc.)
- [ ] Color shades/variants documented
- [ ] Dark mode color palette (if applicable)
- [ ] Background colors specified
- [ ] Text colors for different hierarchies
- [ ] Border/divider colors
- [ ] Shadow colors

### Typography

- [ ] Font families identified
- [ ] All font weights specified (regular, medium, bold, etc.)
- [ ] Font sizes for all text styles
- [ ] Line heights defined
- [ ] Letter spacing values
- [ ] Text hierarchy established (H1-H6, body, caption, etc.)
- [ ] Font files obtained (.ttf or .otf)
- [ ] Font licensing verified

### Spacing

- [ ] Consistent spacing scale defined
- [ ] Padding values for components
- [ ] Margin values between elements
- [ ] Section spacing documented
- [ ] Grid system specified (if used)
- [ ] Gutter sizes defined

### Layout

- [ ] Screen dimensions specified
- [ ] Max content width defined
- [ ] Column counts for different breakpoints
- [ ] Responsive behavior documented
- [ ] Safe area handling specified
- [ ] Scroll behavior defined

### Components

- [ ] All UI components identified
- [ ] Component variants documented
- [ ] Component states specified
- [ ] Component dimensions measured
- [ ] Interactive behavior defined
- [ ] Reusable components vs. one-off instances

### Assets

#### Images

- [ ] All images identified
- [ ] Image dimensions specified
- [ ] Required resolutions listed (1x, 2x, 3x)
- [ ] Image formats specified (PNG, JPG, WebP)
- [ ] Placeholder images for dynamic content

#### Icons

- [ ] All icons identified
- [ ] Icon sizes specified
- [ ] Icon export format chosen (SVG recommended)
- [ ] Icon colors/tints documented
- [ ] Icon states (active, inactive)

#### Illustrations

- [ ] All illustrations identified
- [ ] Illustration formats specified
- [ ] Color variations documented

#### Logos

- [ ] Logo variations collected (light, dark, icon-only)
- [ ] Logo sizes specified
- [ ] Logo clear space defined
- [ ] Logo formats provided (SVG + PNG)

### Effects

- [ ] Shadow specifications (x, y, blur, spread, color)
- [ ] Border radius values
- [ ] Border widths
- [ ] Opacity values
- [ ] Blur effects
- [ ] Gradient specifications (if used)

### Animations

- [ ] All animations identified
- [ ] Animation timing/duration specified
- [ ] Easing curves defined
- [ ] Animation triggers documented
- [ ] Animation assets exported (Lottie, Rive, etc.)

### Interactions

- [ ] Tap/click targets specified
- [ ] Gesture interactions documented
- [ ] Navigation flows defined
- [ ] Modal/overlay behaviors
- [ ] Transition animations
- [ ] Form validation rules
- [ ] Error messages

### Accessibility

- [ ] Color contrast ratios verified (4.5:1 minimum)
- [ ] Touch target sizes defined (44x44 minimum)
- [ ] Alternative text for images
- [ ] Semantic structure defined
- [ ] Focus indicators specified
- [ ] Screen reader considerations

### Content

- [ ] Real content provided (not just Lorem Ipsum)
- [ ] Character limits specified
- [ ] Content overflow handling
- [ ] Placeholder text defined
- [ ] Error messages written
- [ ] Success messages written
- [ ] Validation messages written

### Data

- [ ] Data models/structures defined
- [ ] API endpoints specified
- [ ] Sample data provided
- [ ] Data loading patterns
- [ ] Error handling patterns

## During Development Checklist

### Setup

- [ ] Feature branch created
- [ ] Design system reviewed
- [ ] New tokens added (if needed)
- [ ] Assets imported and organized

### Implementation

- [ ] Layout structure implemented
- [ ] Design tokens used (no hardcoded values)
- [ ] Components reused where possible
- [ ] Responsive behavior implemented
- [ ] All states implemented (loading, error, empty)
- [ ] Interactions/animations added
- [ ] Accessibility features added

### Testing

- [ ] Visual comparison with Figma
- [ ] Tested on multiple screen sizes
- [ ] Tested on iOS device/simulator
- [ ] Tested on Android device/emulator
- [ ] Tested landscape orientation
- [ ] Tested with long content
- [ ] Tested with minimum content
- [ ] Tested all interactive elements
- [ ] Tested error scenarios
- [ ] Performance verified (60fps)

### Accessibility Testing

- [ ] Screen reader tested
- [ ] Color contrast verified
- [ ] Touch targets verified
- [ ] Keyboard navigation tested (web/desktop)
- [ ] Focus order verified

### Code Quality

- [ ] Code follows project style guide
- [ ] Complex logic extracted into functions
- [ ] Reusable widgets extracted
- [ ] Magic numbers eliminated
- [ ] Comments added where needed
- [ ] Documentation added for public APIs

## Pre-Merge Checklist

### Review

- [ ] Self-review completed
- [ ] Design review with designer
- [ ] Code review requested
- [ ] Feedback addressed

### Documentation

- [ ] Changelog updated
- [ ] Screenshots added to PR
- [ ] Breaking changes documented
- [ ] Migration guide provided (if needed)

### Testing

- [ ] Unit tests written
- [ ] Widget tests written
- [ ] Integration tests updated
- [ ] All tests passing

### Final Checks

- [ ] No console warnings
- [ ] No linter errors
- [ ] App builds successfully
- [ ] No performance regressions
- [ ] Meets acceptance criteria

## Post-Merge Checklist

### Deployment

- [ ] Changes merged to main
- [ ] App deployed to staging
- [ ] Smoke tests on staging
- [ ] Deployed to production

### Documentation

- [ ] Component showcase updated
- [ ] Style guide updated
- [ ] Design system documentation updated

### Communication

- [ ] Team notified of changes
- [ ] Designer notified of completion
- [ ] Product owner notified

## Notes

Use this template for each new feature/screen development. Copy and paste into your task tracking system or create a GitHub issue template.

---

**Last Updated:** January 2026  
**Version:** 1.0.0
