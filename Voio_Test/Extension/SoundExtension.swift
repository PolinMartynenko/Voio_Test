//
//  SoundExtension.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 31.10.2022.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
      slider?.value = volume
    }
  }
}
