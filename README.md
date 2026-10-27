# plateforme-assets

Packs d'images, de sons et de projets pour les cahiers **« Mon Premier Jeu de
Plateforme »** (collection *Pixel & Crayon*).

Deux cahiers, deux univers visuels distincts :

| Cahier | Dossier | Héros |
|--------|---------|-------|
| **Scratch** — *Mon Premier Jeu de Plateforme avec Scratch* | [`scratch-platformer/`](scratch-platformer/) | le chat orange |
| **Godot** — *Mon premier jeu de plateforme avec Godot* (« Robi et la Grande Panne ») | [`godot-platformer/`](godot-platformer/) | Robi le robot |

## Le pack Scratch

```
scratch-platformer/
  sprites/   héros (idle / jump / walk / swim), fond transparent
  decors/    4 arrière-plans : vallée (herbe), sous l'eau, montagne, volcan
  ennemis/   5 ennemis (vallée, eau, montagne, volcan, volant), fond transparent
  boss/      le boss du volcan, fond transparent
  objets/    étoile, pièce, gemme, cœur, checkpoint, piques (danger)
  sons/      9 bruitages WAV (départ, saut, pièce, power-up, message, aïe,
             victoire, game over, sélection)
```

Importe les PNG comme costumes de sprite ou arrière-plans, et les WAV comme sons.

## Le pack Godot

```
godot-platformer/
  images/    tout ce que le cahier fait glisser dans Godot : Robi (idle / jump /
             walk / swim), 4 décors, 5 ennemis, le boss, la boule de lave,
             cellule (pièce), étoile, gemme, cœur, checkpoint, piques,
             interrupteur (off / on), porte, générateur (éteint / allumé), plateforme
  tuiles/    les 4 jeux de tuiles (jardin, inondé, gelé, réacteur) : image PNG
             et TileSet Godot (.tres) prêts pour un TileMapLayer
  sons/      les 9 mêmes bruitages WAV
  projet/    le jeu COMPLET du cahier, tel qu'il est à la fin du chapitre 13 :
             ouvre projet/project.godot dans Godot 4.6 et appuie sur F5
```

Les décors sont des scènes larges (1536 × 1024) avec un sol continu, prêtes à
servir d'arrière-plan de niveau. Sprites, ennemis, boss et objets sont sur fond
transparent (PNG RGBA).

Le projet complet sert à comparer avec le sien quand quelque chose ne marche pas,
ou à repartir d'un chapitre : chaque script y est tel qu'il est imprimé dans le
cahier.

## Téléchargement

Les packs prêts à l'emploi sont dans la [dernière release](../../releases) :

- `scratch-platformer-pack-v1.0.1.zip`
- `godot-platformer-pack-v1.1.0.zip`

Chaque cahier contient un QR code qui pointe ici.

## Licence

Ces ressources accompagnent les cahiers et peuvent être utilisées librement par
les enfants pour leurs projets de jeu.
