//
//  markdown.swift
//  QLMarkdown
//
//  Created by C.W. Betts on 1/17/15.
//
//

import Foundation

internal func renderMarkdown(url: NSURL) -> NSData? {
	if let aBund = NSBundle(identifier: "com.fiatdev.QLMarkdown") {
		let styles = String(contentsOfURL: aBund.URLForResource("styles", withExtension: "css")!, encoding: NSUTF8StringEncoding, error: nil)!
		var e: NSError? = nil
		var usedEncoding: NSStringEncoding = 0
		
		if let source = String(contentsOfURL: url, usedEncoding: &usedEncoding, error: &e) {
			if usedEncoding == 0 {
				NSLog("Wasn't able to determine encoding for file “%@”", url.path!)
			}
			var output = convert_markdown_to_string(source)
			let strOutput = String(UTF8String: output)!
			free(output)
			let html = "<!DOCTYPE html>\n<meta charset=utf-8>\n<style>\(styles)</style>\n<base href=\"\(url)\"/>\(strOutput)"
			
			return html.dataUsingEncoding(NSUTF8StringEncoding)
		}
	}
	
	return nil
}
