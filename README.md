# Tower Crane Wire Rope Health Monitoring System

### Culture Code | Smart India Hackathon 2025

A low-cost, retrofit-first system for **continuous health monitoring of tower-crane hoist wire ropes**, designed to detect hidden deterioration, locate anomalies and track rope-health trends before failure.

---

## 🚧 Problem

Tower-crane hoist ropes are exposed to repeated loading, bending, vibration and environmental conditions. Deterioration can develop internally before visible warning signs appear.

Traditional periodic inspection provides only **snapshots** of rope condition, leaving gaps between inspections.

**Hidden deterioration → Rope failure → Crane downtime → Construction disruption → Infrastructure delay**

---

## 💡 Proposed Solution

Our system combines magnetic sensing, position tracking and operating-context sensing:

```text
MFL SENSOR + JIB-TIP SENSOR + ENCODER
                ↓
          STM32 MCU
                ↓
      SIGNAL PROCESSING
                ↓
     ANOMALY DETECTION / ML
                ↓
            WEB UI
                ↓
   ROPE HEALTH + LOCATION + ALERT
