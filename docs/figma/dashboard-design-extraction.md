# Dashboard Design Extraction

**Figma File:** https://www.figma.com/design/5knW5qXCf3yqyA6j6elzeJ/Andi-David  
**Extraction Date:** 2026-01-XX  
**Last Updated:** 2026-01-XX (Section 1 - Meine Ereignisse Card completed)  
**Sections:**
- Section 1: node-id=560-2787
- Section 2: node-id=560-2785  
- Section 3: node-id=560-2760

## Section 1 (node-id=560-2787) - Meine Ereignisse Card

### Layout
- [x] Component type: Card component (AppEventsCard)
- [x] Dimensions: Width: Full width (responsive), Height: Auto (based on content)
- [x] Position: X: N/A, Y: N/A

### Colors
- [x] Background: #FBF7EF (AppColors.backgroundLight / surfaceHighest)
- [x] Text Primary: #242424 (AppColors.textPrimary) - for active events
- [x] Text Secondary: #374151 (AppColors.textSecondary / gray700) - for upcoming events
- [x] Accent/Border: N/A

### Typography
- [x] Title Font: Nunito, Size: 18px, Weight: 600 (semiBold), Line Height: 1.5 (leadingNormal)
- [x] Body Font: Nunito Sans, Size: 16px, Weight: 400 (regular), Line Height: 1.5 (leadingNormal)

### Spacing
- [x] Padding: Top: 20px, Right: 20px, Bottom: 20px, Left: 20px (AppSpacing.all5)
- [x] Gap between items: 8px (AppSpacing.spacing2)
- [x] Margin: Top: N/A, Bottom: N/A
- [x] Gap between title and events: 12px (AppSpacing.v3)

### Borders & Effects
- [x] Border Radius: 16px (AppBorders.xl2)
- [x] Shadow: X: 0, Y: 4, Blur: 6, Spread: -1, Color: #0000001A (AppShadows.md - primary shadow)
- [x] Shadow: X: 0, Y: 2, Blur: 4, Spread: -2, Color: #0000000D (AppShadows.md - secondary shadow)

### Content
- [x] Text content: "Meine Ereignisse" (title), Event list with dates (e.g., "Heute", "Mi, 10.", "Do, 11.") and event names
- [x] Icons/Images: None
- [x] Interactive elements: Optional tap handler (onEventTap callback)

---

## Section 2 (node-id=560-2785)

### Layout
- [ ] Component type: _______________
- [ ] Dimensions: Width: ___px, Height: ___px
- [ ] Position: X: ___px, Y: ___px

### Colors
- [ ] Background: #_______
- [ ] Text Primary: #_______
- [ ] Text Secondary: #_______
- [ ] Accent/Border: #_______

### Typography
- [ ] Title Font: _______, Size: ___px, Weight: ___, Line Height: ___
- [ ] Body Font: _______, Size: ___px, Weight: ___, Line Height: ___

### Spacing
- [ ] Padding: Top: ___px, Right: ___px, Bottom: ___px, Left: ___px
- [ ] Gap between items: ___px
- [ ] Margin: Top: ___px, Bottom: ___px

### Borders & Effects
- [ ] Border Radius: ___px
- [ ] Shadow: X: ___, Y: ___, Blur: ___, Spread: ___, Color: #_______

### Content
- [ ] Text content: _______________
- [ ] Icons/Images: _______________
- [ ] Interactive elements: _______________

---

## Section 3 (node-id=560-2760)

### Layout
- [ ] Component type: _______________
- [ ] Dimensions: Width: ___px, Height: ___px
- [ ] Position: X: ___px, Y: ___px

### Colors
- [ ] Background: #_______
- [ ] Text Primary: #_______
- [ ] Text Secondary: #_______
- [ ] Accent/Border: #_______

### Typography
- [ ] Title Font: _______, Size: ___px, Weight: ___, Line Height: ___
- [ ] Body Font: _______, Size: ___px, Weight: ___, Line Height: ___

### Spacing
- [ ] Padding: Top: ___px, Right: ___px, Bottom: ___px, Left: ___px
- [ ] Gap between items: ___px
- [ ] Margin: Top: ___px, Bottom: ___px

### Borders & Effects
- [ ] Border Radius: ___px
- [ ] Shadow: X: ___, Y: ___, Blur: ___, Spread: ___, Color: #_______

### Content
- [ ] Text content: _______________
- [ ] Icons/Images: _______________
- [ ] Interactive elements: _______________

---

## Implementation Notes

### Design System Mapping
- Colors → AppColors.*
- Typography → AppTypography.*
- Spacing → AppSpacing.*
- Borders → AppBorders.*
- Shadows → AppShadows.*

### Component Structure
- [x] Identify reusable components: AppEventsCard (molecular component)
- [x] Map to existing Flutter widgets: Uses Container, Column, Row, Text
- [x] Create new widgets if needed: AppEventsCard component created at `lib/core/components/molecules/app_events_card.dart`

### Responsive Behavior
- [ ] Mobile (< 768px): _______________
- [ ] Tablet (768px - 1023px): _______________
- [ ] Desktop (1024px+): _______________

---

## Next Steps

1. ✅ Fill in design specifications from Figma Dev Mode (Section 1 completed based on implementation)
2. ✅ Map values to design system tokens (All values mapped to AppColors, AppTypography, AppSpacing, AppBorders, AppShadows)
3. ✅ Implement components (AppEventsCard component implemented)
4. ⏳ Test on different screen sizes (Pending)
5. ⏳ Verify accessibility (Pending)
