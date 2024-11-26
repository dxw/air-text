module SvgHelper
  def render_svg(svg_path, classes: nil, tag: nil)
    asset = find_asset(svg_path + (".svg" unless svg_path.end_with?(".svg")).to_s)
    return unless asset.present?
    return asset.html_safe if tag.nil?

    content_tag(tag, asset.html_safe, class: classes)
  end

  def find_asset(path)
    return unless path.present?

    if Rails.env.production? || Rails.env.staging?
      asset_path = Rails.application.assets_manifest.assets[path]
      File.read(Rails.root.join("public", "assets", asset_path))
    else
      Rails.application.assets[path]&.source
    end
  end
end
