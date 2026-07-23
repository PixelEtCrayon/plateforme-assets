# plateforme-assets

Packs d'images et de sons pour les cahiers **« Mon Premier Jeu de Plateforme »**
(collection *Pixel & Crayon*).

Deux cahiers, deux univers visuels distincts :

| Cahier | Dossier | Héros |
|--------|---------|-------|
| **Scratch** — *Mon Premier Jeu de Plateforme avec Scratch* | [`scratch-platformer/`](scratch-platformer/) | le chat orange |
| **Godot** — *Mon Premier Jeu de Plateforme avec Godot*   | [`godot-platformer/`](godot-platformer/)   | le robot |

## Contenu de chaque pack

```
<moteur>-platformer/
  sprites/   héros (idle / jump / walk), fond transparent
  decors/    4 arrière-plans : vallée (herbe), sous l'eau, montagne, volcan
  ennemis/   4 ennemis (vallée, eau, montagne, volcan), fond transparent
  boss/      le boss du volcan, fond transparent
  objets/    étoile, pièce, gemme, cœur
  sons/      9 bruitages WAV (départ, saut, pièce, power-up, message, aïe,
             victoire, game over, sélection)
```

Les décors sont des scènes larges (1536 × 1024) avec un sol continu, prêtes à
servir d'arrière-plan de niveau. Sprites, ennemis, boss et objets sont sur fond
transparent (PNG RGBA).

## Téléchargement

Les packs prêts à l'emploi sont dans la [dernière release](../../releases) :

- `scratch-platformer-pack-v1.0.0.zip`
- `godot-platformer-pack-v1.0.0.zip`

Chaque cahier contient un QR code qui pointe ici.

## Utilisation

- **Scratch** : importe les PNG comme costumes de sprite / arrière-plans, et les
  WAV comme sons.
- **Godot 4** : glisse les fichiers dans ton projet ; les décors font de bons
  fonds de niveau, les sprites s'utilisent dans un `Sprite2D`.

## Licence

Ces ressources accompagnent les cahiers et peuvent être utilisées librement par
les enfants pour leurs projets de jeu.
