# Comment exécuter des modèles DeepSeek locaux et les utiliser avec MATLAB

Presque immédiatement après la sortie des modèles d'IA DeepSeek-R1, les utilisateurs ont commencé à se renseigner sur leur intégration avec MATLAB. Récemment, Vasileios Papanastasiou, ingénieur en test logiciel chez MathWorks, a partagé des instructions sur LinkedIn, que j'ai décidé d'essayer sur ma propre machine.

## Exécution de DeepSeek-R1:1.5B sur ma machine locale

J'ai utilisé l'extension "Large Language Models (LLMS) with MATLAB" ainsi qu'Ollama pour exécuter l'un des modèles DeepSeek plus petits localement et interagir avec lui dans MATLAB. Suivant les conseils de Vasileios, j'ai d'abord :

1. **Télécharger et installer Ollama** : [Téléchargement d'Ollama](https://ollama.com/download) (j'ai fait cela sur Windows).
2. Après l'installation, j'ai ouvert une ligne de commande et exécuté la commande :
   ```
   ollama run deepseek-r1:1.5b
   ```
   Cette commande installe un modèle de 1,5 milliard de paramètres, qui est relativement petit, ce qui atténue les préoccupations concernant les contraintes de ressources informatiques. Des modèles plus grands peuvent être explorés plus tard.

Ensuite, je me suis tourné vers MATLAB. Bien que Vasileios ait suggéré d'obtenir l'extension "Large Language Models (LLMS) with MATLAB" depuis GitHub, j'ai opté pour une méthode différente :

1. J'ai cliqué sur **Add-ons** dans l'onglet Environnement de MATLAB R2024b.
2. Dans l'Explorateur d'extensions, j'ai recherché "Large Language Models" et cliqué sur "Ajouter" pour compléter le téléchargement et l'installation.

## Interagir avec le modèle dans MATLAB

Avec l'installation terminée, j'étais prêt à expérimenter dans MATLAB. J'ai créé un objet `ollamaChat` :

```matlab
chat = ollamaChat("deepseek-r1:1.5b")
```

Cela a renvoyé les propriétés suivantes :

- **ModelName** : "deepseek-r1:1.5b"
- **Endpoint** : "127.0.0.1:11434"
- **TopK** : Inf
- **MinP** : 0
- **TailFreeSamplingZ** : 1
- **Temperature** : 1
- **TopP** : 1
- **StopSequences** : [0×0 string]
- **TimeOut** : 120
- **SystemPrompt** : []
- **ResponseFormat** : "text"

Maintenant, je pouvais commencer à interagir avec l'IA. Par exemple, j'ai demandé :

```matlab
txt = generate(chat, "Quelle est la vitesse de la lumière ?")
```

La réponse était :

```
<think>
</think>
La valeur exacte de la vitesse de la lumière dans le vide est définie comme \( 299,792,458 \) mètres par seconde.
Cette définition précise garantit la cohérence et l'exactitude dans toutes les mesures et calculs scientifiques.
```

Un aspect intéressant des LLM est leur nature stochastique ; poser la même question plusieurs fois peut donner des réponses différentes. Par exemple :

1. **Première réponse** :
   ```
   La vitesse de la lumière dans le vide est d'environ 299,792 kilomètres (186,282 miles statutaires) par seconde.
   La lumière est la chose la plus rapide de l'univers avec sa limite de vitesse universelle.
   ```

2. **Deuxième réponse** (plus verbeuse) :
   ```
   <think>
   D'accord, j'essaie de comprendre quelle est la vitesse de la lumière...
   ...
   En résumé, la vitesse de la lumière reste une constante, ayant un impact significatif sur divers domaines de la physique et notre compréhension de l'univers.
   </think>
   ```

Bien que le modèle puisse produire des réponses longues et parfois alambiquées, il identifie systématiquement la vitesse de la lumière comme **299,792,458 mètres par seconde**, ce qui est exact selon des sources fiables.

## Conclusion

Bien qu'il s'agisse d'une version plus petite du modèle DeepSeek, il démontre néanmoins des capacités utiles et constitue un moyen engageant d'explorer les forces et les faiblesses de la technologie IA basée sur les LLM. Je vous encourage à l'essayer et à partager vos réflexions !