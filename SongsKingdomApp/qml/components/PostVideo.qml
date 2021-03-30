import Felgo 3.0
import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
  id: feedVideoId
  width: parent.width
  implicitHeight: contentId.height

  property alias previewImageSource: previewImageId.source
  property string videoId: ""

  // mouse area / playback
  MouseArea {
    anchors.fill: parent
    onClicked: {
      youTubePlayer.visible = false
      youTubePlayer.parent = youtubeVideoContainerId
      youTubePlayer.loadVideo(videoId, true) // load and play video
      youTubePlayer.visible = true
    }
  }

  // content
  Item {
    id: contentId
    width: parent.width
    implicitHeight: previewImageContainerId.height

    layer.enabled: true
    layer.effect: DropShadow {
      radius: dp(8)
      samples: 16
      horizontalOffset: dp(2)
      verticalOffset: horizontalOffset
      color: "#16161400"
    }

    // preview image
    Item {
      id: previewImageContainerId
      anchors.fill: youtubeVideoContainerId
      clip: true

      AppImage {
        id: previewImageId
        source: "qrc:/assets/no-image.png"
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        fillMode: AppImage.PreserveAspectFit
      }
    }

    // embedded video
    Item {
      id: youtubeVideoContainerId
      width: parent.width
      height: width / 16 * 9
    }
  }
}

