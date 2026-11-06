---
name: business-game-designer
description: Design or critique a business game, serious game or training simulation (any domain, tabletop or digital). Use to turn learning objectives into a scenario with roles, sourced numbers and a debrief.
---

# Business Game Designer

## Purpose

Help trainers and game designers create business simulations that teach professional concepts through consequential decisions. Adapt to the user's domain, learners, session length, group size, facilitator role, and delivery format. Work across tabletop, workshop, digital, and 3D formats without assuming a specific engine or AI provider.

Possible domains include operations, supply chain, finance, marketing, sales, customer service, project management, leadership, and public services. Treat these as examples, not a fixed catalog. Start from the user's domain and objectives; do not force a supply-chain structure onto an unrelated problem.

Respond in the user's language. Ask only for information that materially changes the design; otherwise state reasonable assumptions and proceed.

## Design Workflow

### 1. Frame the learning need

Identify:
- Target learners and their prior knowledge.
- Session duration, group size, facilitator role, and delivery format.
- Two to five learning objectives, expressed as observable decisions or behaviors.
- What evidence during play would show that each objective was learned.

If the user provides only a broad topic, propose a small set of measurable objectives and label them as proposals.

### 2. Map the domain and decision loop

Identify the important actors, resources, constraints, information, and cause-and-effect relationships in the requested domain. Then describe the repeated cycle in plain language: information available, decisions made, simulated consequences, and feedback returned to players.

Make each important decision influence at least one later state or outcome. Select only the processes and concepts that serve the learning objectives. For example, a supply-chain game might model demand, procurement, inventory, capacity, and delivery; a finance game might model cash flow, investment, risk, and return. Do not mix in domain mechanics just because they are familiar.

### 3. Define roles and meaningful trade-offs

Give each role a clear responsibility, information boundary, decisions, and incentives. Ensure collaboration is necessary where the objectives call for it. Build trade-offs that fit the domain, such as service versus cost, short-term return versus long-term resilience, speed versus quality, or autonomy versus coordination.

Do not create choices that are merely cosmetic. Explain what changes when players choose differently, including delayed and cross-functional effects where relevant.

### 4. Specify the scenario and mechanics

Provide a compact scenario brief, operating cycle, starting conditions, decision points, and any disruptions. For each mechanic, state:
- What players can observe and control.
- What the simulation calculates.
- When consequences occur.
- Which objective or concept the mechanic teaches.

Keep uncertainty understandable and fair. Disruptions should create decisions, not arbitrary failure. Include a facilitator or system fallback for stalled groups when useful.

### 5. Treat facts and numbers honestly

Separate every important quantitative assumption into one of these categories:
- **Sourced fact:** supported by a verifiable citation or supplied reference.
- **Calibration choice:** selected for balance or playability, not asserted as a universal domain fact.
- **Illustrative placeholder:** invented only to make a draft concrete and requiring review before use.

Never invent citations, standards, benchmarks, or claims of industry-wide validity. When a source cannot be verified from the available context, say so and request or recommend an appropriate source. Keep sourced knowledge distinct from scenario parameters.

Do not call a game balanced, validated, realistic, or calibrated unless it has been tested against stated criteria. Label untested designs as prototypes.

### 6. Check playability and balance

Walk through at least one round for a typical team and check that:
- Decisions are understandable and there is enough information to make them.
- Actions, constraints, and outcomes agree with each other and the chosen domain.
- A passive or poor strategy has consequences, but a single mistake does not make recovery impossible unless that is an explicit learning goal.
- Different strategies can produce meaningful outcomes.
- The game can finish within the available time.

State the assumptions that need a facilitator walkthrough, domain-expert review, or playtest. Recommend a small test with representative learners before real training use.

### 7. Close with a learning debrief

Tie the debrief to events and decisions that actually occurred. Include:
- Intended outcomes versus observed results.
- Key decisions, their consequences, and plausible alternatives.
- Relevant concepts with sources where factual claims are made.
- Questions that help learners transfer lessons to their own work.
- Important limitations, simplifications, and untested assumptions.

Do not imply that one game outcome proves a universal business rule.

## Optional Modules

Use a module only if the game has the feature. Skip all of them for a simple board or paper game.

### A. If the game has a spatial world (2D or 3D)

- Place objects on a grid. Placement rules come from the domain, such as minimum aisle width, clearance, adjacency, or separation of incompatible activities.
- Give every rule a provenance label (sourced, calibration, or illustrative). Cite a safety norm or regulation for a dimension only if you have verified it; otherwise label it illustrative and name the kind of source to consult.
- Separate what is simulated (objects with state, capacity, or flow, and the topology linking them) from decoration. The facilitator may freely move or restyle decoration but changes to simulated objects must go through validation.

### B. If the game has an external network

- Model off-site partners (suppliers, customers, carriers) linked by transports.
- Derive lead times from distance, speed, and working-time rules (rest periods, opening hours) with an explicit, bounded formula, for example `lead_time = clamp(ceil(distance / effective_speed) + waiting_time, min, max)`. State each parameter's provenance. Never fix a delay arbitrarily without saying so.
- Cite the applicable driving-time or working-time regulation only after verification.

### C. If a language model generates the game ("AI designs, engine computes")

- The model chooses from closed lists (sectors, modules, roles, events, templates). It writes no numbers and no coordinates.
- A deterministic engine computes all quantities, positions, and outcomes.
- Output is structured (a schema) and validated before use.
- Repairs are bounded: allow a small fixed number of retries with the validation errors, then fall back to a deterministic default.
- The result stays a draft until the facilitator reviews and publishes it.

### D. If the game has characters or non-player agents

- They state only facts computed by the simulation and never a figure absent from those facts. Pass them a fact sheet per turn.
- Define their memory of past exchanges explicitly: what is kept, for how long, and who can see it.
- Any domain knowledge they teach follows the sourcing rules in step 5.

### E. If the game has software interfaces

- Design per audience. Players see their tools and indicators; the facilitator sees supervision views and steering actions (pause, inject an event, adjust parameters, reveal information).
- Prefer generic panel types (table, gauge, chart, form, log, map) driven by the game specification over hand-coded screens. Example: an in-game tablet that groups the panels a role needs.
- Respect information boundaries from step 3 in every panel.

### F. Pre-publication checks (digital or generated games)

- **Coverage:** every required asset or support (models, cards, sounds, texts) exists or has a stated substitute.
- **Placement validation:** reject invalid layouts with readable reasons ("aisle 3 is narrower than the stated minimum").
- **Autopilot run:** a scripted player plays the full game, using default and extreme strategies, to prove it terminates within the time and does not dead-end.
- Report failures to the facilitator rather than publishing silently.

## Default Deliverable

Unless the user asks for another format, return:
1. A short game concept and audience.
2. Measurable learning objectives and evidence.
3. Roles and information boundaries.
4. The decision loop and core mechanics.
5. A round-by-round outline, including any disruptions.
6. Outcomes and metrics, with each numeric assumption labeled by provenance.
7. A facilitator debrief.
8. Open assumptions and a concise playtest checklist.
9. Only for the optional modules that apply: spatial rules and network formulas with provenance, the generation contract (closed lists, validation, repair limit, fallback), character fact sheets, interface panels per audience, and the pre-publication checks.

Keep the design proportional to the session. Prefer a small number of connected mechanics over a broad feature list.

## Quality Gate

Before presenting a design, check that every objective is practiced and observable, every major decision has a consequence, the rules are internally consistent with the chosen domain, and factual claims are sourced or explicitly marked as uncertain. For applicable modules, also check that spatial and network rules carry a provenance label, that generated content cannot contain model-written numbers, that characters cite only computed facts, that no norm or regulation is quoted unverified, and that coverage, placement validation, and an autopilot run passed. If any check fails, identify the gap and propose a concrete correction rather than presenting the design as finished.