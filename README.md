<p align="center">
<img src="https://github.com/tkmonkey/tale_drawer/blob/main/img/logo.png?raw=true" height="250" alt="Tale Drawer Package" />
</p>

---

Collection with many drawer types, including a differents configurations to have more flexibility to implementing drawer in your Flutter applications

<p>
  <img width="205px" alt="Flip" src="https://github.com/tkmonkey/tale_drawer/blob/main/img/flip_preview.gif"/>
  <img width="220px" alt="Guillotine" src="https://github.com/tkmonkey/tale_drawer/blob/main/img/guillotine_preview.gif"/>
  <img width="220px" alt="Zoom" src="https://github.com/tkmonkey/tale_drawer/blob/main/img/zoom_preview.gif" />
</p>

## Installing
Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  tale_drawer: ^latest_version
```
<br>

## Basic Implementation

There are two ways which the TaleDrawer can easily be added to your project.

- Using the TaleDrawer as the root widget for the body (recommended).
- Nesting the TaleDrawer

Change the `type` between: ```TaleType.Flip, TaleType.Guillotine, TaleType.Zoom```

```dart

final type = TaleType.Zoom;

TaleDrawer(
  type: type,
  body: Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xff2E2C3C),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Text('Tale Example'),
    ),
    body: Stack(
      children: [
        Center(child: Text('Hello TKMonkey')),
      ],
    ),
  ),
  drawer: ContentWidget(
    child: ListView.builder(...),
  ),
);

```

## Custom Usage
There are several options that allow for more control:

|  Properties  |   Description   |
|--------------|-----------------|
| `type` | The type of drawer to build `Flip`, `Guillotine`, or `Zoom` |
|`drawer` | The widget that represented the content in the drawer |
| `body` | The Widget displayed overtop the `drawer`, like Scaffold body|
| `drawerBackground` | Background of drawer content widget |
| `sideState` | Chooose between Left and Right side to change animation direction |
| `drawerState` | Choose the drawer start open or close |
| `settings` | Set specific settings for the type of `drawer`, help to set a custom behavior for `TaleDrawer` |
| `listener` | Set listener to get updates, of changes in state |
| `controller` | Create a custom controller to control the animation behavior and state  of the `drawer` |

<br>
<br>

### Using the `TaleController`
At times, it can be useful to manually change the state of the `TaleDrawer`. This can be easily achieved by using a `TaleController`. Note that since the `TaleController` modifies the state of a `TaleDrawer`.

|  Properties  |  Description |
|--------------|--------------|
|`drawerPosition`|  Evaluates to the current drawer position (a value between 0.0 and 1.0) |
|`isDrawerOpen`| Returns whether or not the drawer is open. |
|`isDrawerClosed`| Returns whether or not the drawer is collapsed.|

<br>

|  Methods  |   Description |
|-----------|-------------|
|`open()`|  Opens the the drawer fully |
|`close()`| Closes the drawer fully |
|`start()`|  Execute open or close functions depends on the situation |


```dart
final controller = TaleController();

@override
Widget build(BuildContext context) {
  return TaleDrawer(
    type: type,
    controller: controller,
    body: ...,
    drawer: ...,
  );
}